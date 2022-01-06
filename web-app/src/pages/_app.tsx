import Head from 'next/head'
import type { AppProps } from 'next/app'
import { SessionProvider } from "next-auth/react"
import { ChakraProvider } from '@chakra-ui/react'
import {ThemeContextProvider} from '../providers/themeContext'

function MyApp({ Component, pageProps:{session, ...pageProps} }:AppProps) {

  return (
    <>
        <Head>
            <link rel="preconnect" href="https://fonts.googleapis.com"></link>
            <link rel="preconnect" href="https://fonts.gstatic.com"></link>
            <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet"></link>
        </Head>

        <ThemeContextProvider>
            <ChakraProvider>
                <SessionProvider session={session}>
                        <Component {...pageProps} />
                </SessionProvider>
            </ChakraProvider>
        </ThemeContextProvider>
    </>  
  )
}

export default MyApp