import { useContext } from "react";
import { ThemeContext } from "../providers/themeContext";

export function useTheme(){
    const theme = useContext(ThemeContext)
    return theme
}