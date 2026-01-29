import { useState, useEffect } from 'react';
import { useSession } from 'next-auth/react';
import api from '@/lib/api';

export function useUserData() {
    const { data: session } = useSession();
    const [usuario, setUsuario] = useState("");
    const [userCompanies, setUserCompanies] = useState<string[]>([]);

    useEffect(() => {
        if (session?.user?.preferred_username) {
            const email = session.user.preferred_username;
            const username = email.split('@')[0];
            setUsuario(username);
        }
    }, [session]);

    return { usuario, setUsuario, userCompanies };
}
