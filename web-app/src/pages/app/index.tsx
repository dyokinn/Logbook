import { Box, Button, Center, Container, Flex } from '@chakra-ui/react'
import type { NextPage } from 'next'
import ship from '../../public/images/navio.jpg'
import Image from 'next/image'
import Aside from '../../components/app/aside/aside'

const Home: NextPage = () => {
  return (
    <Box backgroundColor="dark.black" w="100vw">
        <Aside/>
    </Box>
  )
}

export default Home