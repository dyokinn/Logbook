import logo from '../../../public/images/logo_with_text.png'
import { useSession, signIn, signOut } from "next-auth/react"
import { FiDownload, FiLogIn, FiMoon, FiSun } from "react-icons/fi";
import Image from 'next/image'
import { useTheme } from '../../hooks/useTheme';
import styled from 'styled-components';
import { StyledButton, StyledIconButton } from '../mui-styled/buttons';

const NavBarWrapper = styled.div<{backgroundColor: string}>`
    height: 10vh;
    width: 100vw;
    padding: 10px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    align-items: center;
    background-color: ${props => props.backgroundColor};
`

const Actions = styled.div`
    display: flex;
    flex-direction: row;
    gap: 50px;
`
const NavBar = () =>{
    const {mode, theme, setModeOpt} = useTheme()

    return(
        <NavBarWrapper backgroundColor = {theme.main}>
            <Image src={logo} height={80} width={80}/>
                <Actions>
                    <StyledIconButton onClick={() => setModeOpt()}>
                        {mode === "dark"
                         ? <FiMoon size={50} color={theme.text}/>
                         : <FiSun size={50} color={theme.text}/>
                        }
                    </StyledIconButton>
                    <StyledButton backgroundColor={theme.blue}> Baixar o app</StyledButton>
                    <StyledButton backgroundColor={theme.green} endIcon={<FiLogIn/>}> Login (Web)</StyledButton>
                </Actions>            
        </NavBarWrapper>
    )
}

export default NavBar