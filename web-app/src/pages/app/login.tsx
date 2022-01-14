import { Flex } from '@chakra-ui/react'
import type { NextPage } from 'next'
import { signIn, signOut, useSession } from 'next-auth/react'
import { useRouter } from 'next/router'
import NavBar from '../../components/landing/navBar'
import { useTheme } from '../../hooks/useTheme'

const Login: NextPage  = () => {

    const {mode, theme, setModeOpt} = useTheme()
    const { data: session } = useSession()
    const router = useRouter()

    // Redirect para o app caso já esteja logado
    if (session) {
        router.replace("/app")
    }
    
    return (
        <Flex backgroundColor={theme.second} flexDirection={"column"} >
            Not signed in <br />
            <button onClick={() => signIn()}>Sign in</button>
        </Flex>
    )
}


export default Login