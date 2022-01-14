
import { Box, Button, Slide, Flex, IconButton, useDisclosure, Avatar } from '@chakra-ui/react'
import { useSession } from 'next-auth/react';
import React, { useState } from 'react'
import { FiMenu, FiChevronLeft} from "react-icons/fi";
import { useTheme } from '../../../hooks/useTheme';


const Aside = () => {
    const { isOpen, onToggle } = useDisclosure()
    const {mode, theme, setModeOpt} = useTheme()
    const { data: session } = useSession()

    return(
        <>
        <Flex h={"100vh"} w={20} paddingTop={5} justifyContent={"center"} backgroundColor={theme.main} >
            <IconButton backgroundColor={theme.main} _focus={{}} _hover={{}}  icon={<FiMenu size={30} color={theme.text}/>} aria-label='Search database' onClick={onToggle}/>
        </Flex>
        <Slide direction='left' in={isOpen} style={{ zIndex: 10 }}>
            <Box h={"100vh"} w={280} backgroundColor={theme.main} >
                <IconButton marginTop={5} marginLeft={"75%"} backgroundColor={theme.main} _focus={{}} _hover={{}}  icon={<FiChevronLeft size={30} color={theme.text}/>} aria-label='Search database' onClick={onToggle}/>
            </Box>
            <Flex>
                <Avatar name='Oshigaki Kisame' src={session?.user?.image!} />
                <h1>{session?.user?.name}</h1>
            </Flex>
        </Slide>
        </>
    )
}

export default Aside