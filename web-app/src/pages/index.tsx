import type { NextPage } from 'next'
import ship from '../../public/images/navio.jpg'
import Image from 'next/image'
import NavBar from '../components/landing/navBar'
import Card from '../components/landing/card'
import { FiAnchor, FiBook, FiDownload, FiLock, FiStar } from "react-icons/fi";
import { useTheme } from '../hooks/useTheme'
import { Button, Center, Flex, Heading, Text } from '@chakra-ui/react'

const Home: NextPage = () => {

  const {mode, theme, setModeOpt} = useTheme()

  return (
    <Flex backgroundColor={theme.second} flexDirection={"column"} >
        <NavBar/>

        <Flex flexDirection={"row"} h={"100vh"} >
            <Flex flexDirection={"column"} paddingTop={"50vh"}>
                <Heading as={"h1"} color={theme.text}>
                    Registre sua jornada!
                </Heading>
                <Text color={theme.text} >
                    Guarde seus relatos, emoções e acontecimentos do dia a dia em um só app.
                </Text>
                <Button w={200} backgroundColor={theme.green} _hover={{}} rightIcon={<FiDownload />}> Baixar o app</Button>
            </Flex>
            <Center></Center>
        </Flex>
        
        <Flex backgroundColor={theme.main} flexDirection={"row"} alignItems={"center"} justifyContent={"space-evenly"} h={"90vh"} >
            <Card 
                icon={FiStar}
                headline='Simples'
                text='Intuitivo e efetivo, feito sob medida para facilitar seu uso e acompanhamento.'
            />
            <Card 
                icon={FiLock}
                headline='Seguro'
                text='Nos comprometemos com a segurança dos seus relatos e não guardamos nenhum tipo de informação
                sensível da sua conta'
            />
            <Card 
                icon={FiBook}
                headline='Eficiente'
                text='Guarde quantos registros quiser no seu histórico. É de graça!'
            />
        </Flex>
    </Flex>
  )
}

export default Home
