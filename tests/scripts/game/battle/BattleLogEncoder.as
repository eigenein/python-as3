package game.battle
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class BattleLogEncoder
   {
      
      private static const encodeTable:String = "1234567890-=_qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
      
      private static const encodeMap:Dictionary = new Dictionary();
      
      private static const decodeMap:Dictionary = new Dictionary();
      
      private static var initialized:Boolean = false;
       
      
      public function BattleLogEncoder()
      {
         super();
      }
      
      protected static function initialize() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public static function printLogFromErrorList(param1:String) : void
      {
         var _loc6_:Array = param1.match(/, (.)*?\t/g);
         var _loc4_:String = "";
         var _loc9_:int = 0;
         var _loc8_:* = _loc6_;
         for each(var _loc2_ in _loc6_)
         {
            _loc4_ = _loc2_.slice(2,_loc2_.length - 1) + _loc4_;
         }
         var _loc7_:String = decode(_loc4_);
         trace(_loc7_.slice(0,_loc7_.indexOf(" # ")));
         _loc7_ = _loc7_.slice(_loc7_.indexOf(" # ") + 3);
         var _loc3_:Array = _loc7_.split("\n");
         var _loc11_:int = 0;
         var _loc10_:* = _loc3_;
         for each(var _loc5_ in _loc3_)
         {
            trace(battle.log.BattleLogEncoder.decodeToString(_loc5_));
         }
      }
      
      public static function decode(param1:String) : String
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:* = 0;
         if(!initialized)
         {
            initialize();
         }
         var _loc5_:int = param1.charAt(0);
         var _loc4_:ByteArray = new ByteArray();
         var _loc7_:int = param1.length;
         _loc8_ = 1;
         while(_loc8_ < _loc7_)
         {
            _loc9_ = decodeMap[param1.charAt(_loc8_)];
            _loc2_ = decodeMap[param1.charAt(_loc8_ + 1)];
            _loc3_ = decodeMap[param1.charAt(_loc8_ + 2)];
            _loc6_ = _loc9_ | _loc2_ << 6 | _loc3_ << 12;
            _loc4_.writeShort(_loc6_);
            _loc8_ = _loc8_ + 3;
         }
         _loc4_.length = _loc4_.length - _loc5_;
         _loc4_.position = 0;
         _loc4_.inflate();
         _loc4_.position = 0;
         return _loc4_.readUTFBytes(_loc4_.length);
      }
      
      public static function encode(param1:String) : String
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
