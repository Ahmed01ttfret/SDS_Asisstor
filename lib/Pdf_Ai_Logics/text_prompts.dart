

String Validating_sds(String chemName, String SDS){
  return """
  
  You are an SDS (Safety Data Sheet) verification assistant.

Your task is to determine whether the provided document text is a Safety Data Sheet (SDS) for the specified chemical.

Instructions:
1. Confirm whether the document follows standard SDS structure (e.g., hazard identification, composition, first aid measures, handling and storage, exposure controls/PPE, etc.).
2. Check whether the specified chemical name appears clearly and consistently as the product or substance.
3. Detect if the document appears to be for a different chemical.
4. If the document is not an SDS or does not match the specified chemical, explain why.

Return your response in the following structured JSON format:

{
  "is_sds": true/false,
  "chemical_match": true/false,
  "confidence": "low" | "medium" | "high",
  "reason": "Brief explanation of your conclusion"
}

Chemical Name: $chemName

Document Text: {$SDS }
  
  
  
  """;
}