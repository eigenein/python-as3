package be.boulevart.events
{
   import flash.events.Event;
   
   public class FLVRecorderEvent extends Event
   {
      
      public static var FLV_START_CREATION:String = "flvCreationStarted";
      
      public static var FLV_CREATED:String = "flvCreated";
      
      public static var PROGRESS:String = "progress";
       
      
      private var _urlToFLV:String;
      
      private var _prgr:Number;
      
      public function FLVRecorderEvent(param1:String, param2:String = "", param3:Number = 0, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this._urlToFLV = param2;
         this.progress = param3;
      }
      
      public function get url() : String
      {
         return _urlToFLV;
      }
      
      public function get progress() : Number
      {
         return _prgr;
      }
      
      public function set progress(param1:Number) : void
      {
         _prgr = param1;
      }
   }
}
