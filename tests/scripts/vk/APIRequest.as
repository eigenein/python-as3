package vk
{
   final class APIRequest
   {
       
      
      public var method:String;
      
      public var params:Object;
      
      public var success:Function;
      
      public var error:Function;
      
      function APIRequest(param1:String, param2:Object, param3:Function, param4:Function)
      {
         super();
         this.method = param1;
         this.params = param2;
         this.success = param3;
         this.error = param4;
      }
      
      public function invoke(param1:Object) : void
      {
         if(param1 != null && param1.response != null && success != null)
         {
            success.call(null,param1.response);
         }
         else if(param1 != null && param1.error != null && error != null)
         {
            error.call(null,param1.error);
         }
      }
   }
}
