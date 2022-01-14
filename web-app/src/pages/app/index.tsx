import { Box, Button, Center, Container, Flex } from '@chakra-ui/react'
import type { NextPage } from 'next'
import ship from '../../public/images/navio.jpg'
import Image from 'next/image'
import Aside from '../../components/app/aside/aside'
import { useTheme } from '../../hooks/useTheme'

const Home: NextPage = () => {
    const {mode, theme, setModeOpt} = useTheme()
    
    return (
        <Box backgroundColor={theme.second} h={"100vh"} w={"100vw"}>
            <Aside/>
        </Box>
    )
}

export default Home