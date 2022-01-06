import logo from '../../../public/images/logo_with_text.png'
import { useSession, signIn, signOut } from "next-auth/react"
import { FiDownload, FiLogIn, FiMoon, FiSun } from "react-icons/fi";
import Image from 'next/image'
import { useTheme } from '../../hooks/useTheme';
import styled from 'styled-components';
import { Box, Button, Flex, IconButton } from '@chakra-ui/react';
import { useRouter } from 'next/router'

const NavBar = () =>{
    const {mode, theme, setModeOpt} = useTheme()
    const router = useRouter()

    return(
        <Flex position={"fixed"} padding={10} h={"10vh"} w={"100vw"} justifyContent={"space-between"} alignItems={"center"} flexDirection={"row"} backgroundColor={theme.main} zIndex={50}>
            {mode === "dark"
                    ? <Image src={logo} height={80} width={80}/>
                    : <h1>Logbook</h1> 
            }
            <Flex gap={5}>
                {mode === "dark"
                    ? <IconButton backgroundColor={theme.main} _focus={{}} _hover={{}}  icon={<FiMoon size={30} color={theme.text}/>} aria-label='Search database' onClick={() => setModeOpt()}/>
                    : <IconButton backgroundColor={theme.main} _focus={{}} _hover={{}}  icon={<FiSun size={30} color={theme.text}/>} aria-label='Search database' onClick={() => setModeOpt()}/>
                }
                <Button backgroundColor={theme.green} _hover={{}} rightIcon={<FiDownload />}> 
                    Baixar o app
                </Button>
                <Button backgroundColor={theme.green} _hover={{}} rightIcon={<FiLogIn/>} onClick={() => {
                    router.push("/app/login")
                }}>
                    Login (Web)
                </Button>
            </Flex>            
        </Flex>
    )
}

export default NavBar