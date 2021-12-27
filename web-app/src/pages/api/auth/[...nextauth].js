import NextAuth from 'next-auth'
import Providers from 'next-auth/providers'

import firebase from "firebase/app"
import "firebase/firestore"
import {firebaseConfig} from "../../../services/firebase"

const firebaseAuth = (
    firebase.apps[0] ?? firebase.initializeApp(firebaseConfig)
).firestore()

export default NextAuth({
  // Configure one or more authentication providers
  providers: [
    Providers.Google({
        clientId: process.env.FIREBASE_CLIENT_ID,
        clientSecret: process.env.FIREBASE_CLIENT_SECRET,
    })
  ],
  adapter: FirebaseAdapter(firebaseAuth),
})