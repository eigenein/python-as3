package starling.utils
{
   import flash.events.EventDispatcher;
   import flash.system.Capabilities;
   import flash.utils.getDefinitionByName;
   import starling.errors.AbstractClassError;
   
   public class SystemUtil
   {
      
      private static var sInitialized:Boolean = false;
      
      private static var sApplicationActive:Boolean = true;
      
      private static var sWaitingCalls:Array = [];
      
      private static var sPlatform:String;
      
      private static var sVersion:String;
      
      private static var sAIR:Boolean = false;
       
      
      public function SystemUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function initialize() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(sInitialized)
         {
            return;
         }
         sInitialized = true;
         sPlatform = Capabilities.version.substr(0,3);
         sVersion = Capabilities.version.substr(4);
         try
         {
            _loc2_ = getDefinitionByName("flash.desktop::NativeApplication");
            _loc1_ = _loc2_["nativeApplication"] as EventDispatcher;
            _loc1_.addEventListener("activate",onActivate,false,0,true);
            _loc1_.addEventListener("deactivate",onDeactivate,false,0,true);
            sAIR = true;
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      private static function onActivate(param1:Object) : void
      {
         sApplicationActive = true;
         var _loc4_:int = 0;
         var _loc3_:* = sWaitingCalls;
         for each(var _loc2_ in sWaitingCalls)
         {
            _loc2_[0].apply(null,_loc2_[1]);
         }
         sWaitingCalls = [];
      }
      
      private static function onDeactivate(param1:Object) : void
      {
         sApplicationActive = false;
      }
      
      public static function executeWhenApplicationIsActive(param1:Function, ... rest) : void
      {
         initialize();
         if(sApplicationActive)
         {
            param1.apply(null,rest);
         }
         else
         {
            sWaitingCalls.push([param1,rest]);
         }
      }
      
      public static function get isApplicationActive() : Boolean
      {
         initialize();
         return sApplicationActive;
      }
      
      public static function get isAIR() : Boolean
      {
         initialize();
         return sAIR;
      }
      
      public static function get isDesktop() : Boolean
      {
         initialize();
         return /(WIN|MAC|LNX)/.exec(sPlatform) != null;
      }
      
      public static function get platform() : String
      {
         initialize();
         return sPlatform;
      }
      
      public static function get version() : String
      {
         initialize();
         return sVersion;
      }
      
      public static function get supportsRelaxedTargetClearRequirement() : Boolean
      {
         return parseInt(/\d+/.exec(sVersion)[0]) >= 15;
      }
   }
}
