import styled from 'styled-components'
import { ReactChild } from "react"
import { IconType } from "react-icons"
import { Box, Center, Icon, Heading, Text } from '@chakra-ui/react'
import { useTheme } from '../../hooks/useTheme'

type CardProps = {
    icon: IconType,
    headline: string,
    text: string
} 

const Card = (props: CardProps) => {
    const {mode, theme, setModeOpt} = useTheme()

    return(
        <Box h="400px" w="300px" gap={20} border="1px solid" borderRadius="15px">
            <Center h={"30%"}>
                <Icon as={props.icon} color={theme.text} h={70} w={70} />
            </Center>
            <Box>
                <Heading color={theme.text} textAlign={"center"} marginBottom={"10%"}>{props.headline}</Heading>
                <Text color={theme.text} textAlign={"center"}>{props.text}</Text>
            </Box>
        </Box>
    )
}

export default Card