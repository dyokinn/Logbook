import { Flex } from '@chakra-ui/react'
import type { NextPage } from 'next'
import { signIn, signOut, useSession } from 'next-auth/react'
import NavBar from '../../components/landing/navBar'
import { useTheme } from '../../hooks/useTheme'

const Login: NextPage  = () => {

    const {mode, theme, setModeOpt} = useTheme()
    const { data: session } = useSession()

    if (session) {
        return (
          <>
            Signed in as {session.user?.email} <br />
            <button onClick={() => signOut()}>Sign out</button>
          </>
        )
      }
      return (
        <>
          Not signed in <br />
          <button onClick={() => signIn()}>Sign in</button>
        </>
      )
}


export default Login