import type { NextApiRequest, NextApiResponse } from 'next'
import prisma  from '../../../services/lib/prisma';

export default async function handler(
    req: NextApiRequest,
    res: NextApiResponse
) {
    const {
        googleId,      
    } = req.body

    try {
        const result = await prisma.user.create(
            {
                data: {
                    googleId: googleId.toString()
                }
            }
        )
        res.status(201).json(result)

    } catch (error) {
        res.status(400).json({"error": "Error during creation"})
    }

}
