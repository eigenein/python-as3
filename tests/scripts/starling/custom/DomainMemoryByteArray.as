package starling.custom
{
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class DomainMemoryByteArray
   {
       
      
      private var domain:ApplicationDomain;
      
      public var p:int;
      
      public const byteArray:ByteArray = new ByteArray();
      
      public function DomainMemoryByteArray()
      {
         super();
         domain = ApplicationDomain.currentDomain;
         byteArray.endian = "littleEndian";
      }
      
      public function setSize(param1:int) : void
      {
         if(byteArray.length < param1)
         {
            if(domain.domainMemory == byteArray)
            {
               domain.domainMemory = null;
            }
            if(param1 < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
               param1 = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            byteArray.length = param1;
         }
      }
      
      public function setReadyForSize(param1:int) : void
      {
         if(byteArray.length < param1)
         {
            if(domain.domainMemory == byteArray)
            {
               domain.domainMemory = null;
            }
            if(param1 < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
            {
               param1 = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
            }
            byteArray.length = param1;
            domain.domainMemory = byteArray;
         }
         else if(domain.domainMemory != byteArray)
         {
            domain.domainMemory = byteArray;
         }
      }
   }
}
