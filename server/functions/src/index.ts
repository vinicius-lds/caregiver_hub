import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {DocumentSnapshot} from "firebase-functions/v1/firestore";
import {createGeohashes} from "proximityhash";

admin.initializeApp({
  credential: admin.credential.applicationDefault(),
});
const db = admin.firestore();

export const helloWorld = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs!", {structuredData: true});
  response.send("Hello from Firebase!");
});

const updateCaregiverRating = async (snapshot: DocumentSnapshot) => {
  const data = snapshot.data();
  const caregiverId = (data || {})["caregiverId"];
  if (!caregiverId) {
    return;
  }

  const ratings = await db.collection("caregiverRecomendations")
      .where("caregiverId", "==", caregiverId)
      .select("rating")
      .get();

  const ratingsCount = ratings.docs.length;
  const ratingsSum = ratings.docs
      .reduce((acc, curr) => acc + curr.data()["rating"], 0);

  await db.collection("users")
      .doc(caregiverId)
      .update({rating: ratingsSum / ratingsCount});
};

export const onWriteCaregiverRecomendation = functions.firestore
    .document("caregiverRecomendations/{caregiverRecomendationId}")
    .onWrite(async (change) => await updateCaregiverRating(change.after));

export const onDeleteCaregiverRecomendation = functions.firestore
    .document("caregiverRecomendations/{caregiverRecomendationId}")
    .onDelete(async (change) => await updateCaregiverRating(change));


interface Coordinates {
  latitude: number;
  longitude: number;
}

const updateCaregiverGeoHashes = async (snapshot: DocumentSnapshot) => {
  const data: any = snapshot.data();

  const showAsCaregiver = !!(data || {})["showAsCaregiver"];
  if (!showAsCaregiver) {
    return;
  }

  const afterCoordinates: Coordinates =
      ((data || {})["location"] || {})["coordinates"];
  const afterRadius: number =
      ((data || {})["location"] || {})["radius"];

  // for reference: https://github.com/SHAINAAZ992/proximityhash
  const geoHashes = createGeohashes({
    latitude: afterCoordinates.latitude,
    longitude: afterCoordinates.longitude,
    radius: afterRadius,
    precision: 7,
    georaptorFlag: true,
    minlevel: 1,
    maxlevel: 12,
    approxHashCount: true,
  });

  console.log("geoHashes.length:", geoHashes.length);

  await db.collection("users").doc(snapshot.id).update({
    location: {
      ...data["location"],
      geoHashes: geoHashes,
    },
  });
};

export const onWriteUser = functions.firestore
    .document("users/{userId}")
    .onWrite(async (change) => await updateCaregiverGeoHashes(change.after));
