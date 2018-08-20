package game.util
{
   import com.progrestar.common.error.ClientErrorManager;
   import flash.net.SharedObject;
   
   public class ConsoleSOStorage
   {
      
      private static var _instance:ConsoleSOStorage;
       
      
      private var so:SharedObject;
      
      public function ConsoleSOStorage()
      {
         super();
         so = SharedObject.getLocal("hero_console","/");
      }
      
      public static function get instance() : ConsoleSOStorage
      {
         if(!_instance)
         {
            _instance = new ConsoleSOStorage();
         }
         return _instance;
      }
      
      public function getLastCommands() : Vector.<String>
      {
         var _loc3_:int = 0;
         var _loc2_:* = undefined;
         var _loc4_:int = 0;
         var _loc1_:* = so.data.commands;
         if(_loc1_)
         {
            _loc3_ = _loc1_.length;
            _loc2_ = new Vector.<String>(0);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_[_loc4_] = _loc1_[_loc4_];
               _loc4_++;
            }
         }
         return _loc2_ || new Vector.<String>(0);
      }
      
      public function setLastCommands(param1:Vector.<String>) : void
      {
         while(param1.length > 4000)
         {
            param1.shift();
         }
         so.data.commands = param1 != null?param1:new Vector.<String>(0);
         try
         {
            so.flush();
            return;
         }
         catch(e:Error)
         {
            trace(e);
            ClientErrorManager.action_handleError(e);
            return;
         }
      }
      
      public function getTestData() : *
      {
         if(!so.data.testData)
         {
            so.data.testData = {};
         }
         return so.data.testData;
      }
      
      public function getSearchString() : String
      {
         return so.data.search || "";
      }
      
      public function setSearchString(param1:String) : void
      {
         so.data.search = param1;
         try
         {
            so.flush();
            return;
         }
         catch(e:Error)
         {
            trace(e);
            ClientErrorManager.action_handleError(e);
            return;
         }
      }
   }
}
