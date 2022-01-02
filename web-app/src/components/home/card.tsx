import styled from 'styled-components'
import { ReactChild } from "react"
import { IconType } from "react-icons"

type CardProps = {
    icon: IconType,
    children: ReactChild[]
} 

const CardWrapper = styled.div`
    height: 400px;
    width: 300px;
    gap: 20px;
    border: 1px solid;
    border-color: ${({ theme})=> theme.colors.background};
    border-radius: 15px;
`

const Card = (props: CardProps) => {
    return(
        <Box h="400px" w="300px" gap={20} border="1px solid" borderColor="dark.green" borderRadius="15px">
            <Center h={"40%"}>
                <Icon as={props.icon} h={70} w={70} />
            </Center>
            <Box>
                <p>
                    {props.children}
                </p>
            </Box>
        </Box>
    )
}

export default Card