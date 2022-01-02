
import { Box, Flex, IconButton } from '@chakra-ui/react'
import React, { useState } from 'react'
import { FiArrowRight} from "react-icons/fi";


const Aside = () => {
    const [isOpen, setIsOpen] = useState(false)
    return(
        <Flex h="100vh" w="10vw" flexDirection="column" backgroundColor="dark.gray">
            <IconButton icon={<FiArrowRight/>} color="dark.green" aria-label='open drawer' />
        </Flex>
    )
}

export default Aside