DIR="./toDeploy/profiles"
if [ -d "$DIR" ]; then
   if ls ${DIR}/*.profile &> /dev/null ; then
      echo "Removendo permissões de usuários dos perfis adicionados..."
      sed -i -e "/<userPermissions>/,/<\/userPermissions>/d" ${DIR}/*.profile
   else
      echo "Não foram encontrados arquivos de perfis."
   fi
else
   echo "Não há perfis adicionados."
fi