public class Metadado {

    @AuraEnabled(cacheable=true)
    public static List<devmanju__Campos_Dinamicos__mdt> getNegociacaoCampo(){

        Map<String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('devmanju__Campos_Dinamicos__mdt').getDescribe().fields.getMap();
        List<String> fieldNames = new List<String>();
        
        for (String fieldName : fieldMap.keySet()) {
            fieldNames.add(fieldName);
        }
        
        String query = 'SELECT ' + String.join(fieldNames, ',') + ' FROM devmanju__Campos_Dinamicos__mdt ORDER BY NUM_Posicao__c ASC';
        return Database.query(query);
    }

    @AuraEnabled(cacheable=false)
    public static List<Account> getConta(Id recordId, List<devmanju__Campos_Dinamicos__mdt> metadado) {

        try {
            List<String> accountFieldsList = new List<String>();

            for (devmanju__Campos_Dinamicos__mdt campo : metadado) {
                if (campo.TXT_Objeto__c == 'Account') {
                    accountFieldsList.add(campo.devmanju__TXP_API__c);
                }
            }

            String accountFields = String.join(accountFieldsList, ',');

            String query = 'SELECT Id';

            if (!accountFieldsList.isEmpty()) {
                query += ', ' + accountFields;
            }

            String contaId = recordId;

            query += ' FROM Account WHERE Id = \'' + contaId + '\'';

            System.debug('query ===> ' + query);

            List<Account> accounts = Database.query(query);

            System.debug('accounts => '+JSON.serialize(accounts));
            return accounts;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }
}