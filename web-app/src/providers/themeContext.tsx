import { createContext, useEffect, useState } from "react"

// Definindo tipo do valor do contexto
type themeContext = {
    mode: string
    setModeOpt: () => void
    theme: colors
}

type colors = {
    main : string
    second : string
    blue : string
    green : string
    red : string
    text:string
}

// Exportando o contexto para o Provider abaixo e outras páginas
export const ThemeContext = createContext({} as themeContext)  

// Exporta funcionamento do contexto no componente de rotas
export const ThemeContextProvider = (props:any) => {
    
    // Informações relevantes
    let info = {
        dark:{
            main : "#0D1117",
            second : "#2A2F32",
            blue : "#1db0d6",
            green : "#26E68A",
            red : "#ff5757",
            text: "#f5f5f5"
        },
        light:{
            main : "#fafafa",
            second : "#d4d4d4",
            blue : "#1db0d6",
            green : "#26E68A",
            red : "#ff5757",
            text: "#1a1a1a"
        }
    }

    const [mode, setMode] = useState("dark")
    const [theme, setTheme] = useState<colors>((info as any)["dark"])

    const setModeOpt = () =>{
        if(mode === "dark") {
            setMode("light")
        }
        else {
            setMode("dark")
        }
    }

    useEffect(() => {
        setTheme((info as any)[mode])
    }, [mode])

    return(
        // Aqui definimos o que será compartilhado neste contexto para o comp. rotas       
        <ThemeContext.Provider value= {{
            mode: mode,
            theme: theme,
            setModeOpt: setModeOpt
        }}> 
            {props.children}
        </ThemeContext.Provider>
        
    )
} 