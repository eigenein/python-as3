package battle.log
{
   import flash.Boot;
   import format.tools.Inflate;
   import haxe.IMap;
   import haxe.crypto.Base64;
   import haxe.ds.IntMap;
   import haxe.io.Bytes;
   import haxe.io.BytesInput;
   
   public class BattleLogReader extends BytesInput
   {
       
      
      public var time:Number;
      
      public var stringsCount:int;
      
      public var strings:IMap;
      
      public var lastEventId:int;
      
      public var currentEventId:int;
      
      public var currentEventBytePosition:int;
      
      public function BattleLogReader(param1:String = undefined)
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as String;
         if(Boot.skip_constructor)
         {
            return;
         }
         strings = new IntMap();
         var _loc2_:Bytes = Base64.decode(param1);
         _loc2_ = Inflate.run(_loc2_);
         super(_loc2_);
         set_position(0);
         stringsCount = int(readInt16());
         var _loc3_:int = 0;
         var _loc4_:int = stringsCount;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = readInt16();
            _loc7_ = readByte();
            _loc8_ = readString(_loc7_);
            strings.h[_loc6_] = _loc8_;
            _loc8_;
         }
      }
      
      public function readEncodedString() : String
      {
         var _loc1_:int = readInt16();
         return strings.h[_loc1_];
      }
   }
}
