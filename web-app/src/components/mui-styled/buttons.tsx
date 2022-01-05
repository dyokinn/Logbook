import { Button, IconButton } from '@mui/material';
import styled from 'styled-components';

const StyledButton = styled(Button)<{backgroundColor: string, textColor: string}>`
    background-color: ${props => props.backgroundColor};
    color: ${props => props.textColor};
    &:hover{
        background-color: red;
    }

`

const StyledIconButton = styled(IconButton)`
`
// const StyledIconButton = styled(IconButton)<{backgroundColor: string}>`
//     background-color: ${props => props.backgroundColor};
// `

export {StyledButton ,StyledIconButton}