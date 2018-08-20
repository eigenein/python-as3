package vm
{
   import haxe.io.Bytes;
   
   public class PreParser
   {
       
      
      public var total:int;
      
      public var parts:Array;
      
      public var output:Array;
      
      public var flags:Array;
      
      public function PreParser()
      {
      }
      
      public function skip(param1:int) : int
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function process(param1:String, param2:Array) : Bytes
      {
         var _loc6_:* = null;
         var _loc7_:* = null as SplitInfo;
         var _loc10_:int = 0;
         var _loc12_:* = null as String;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         total = param1.length;
         parts = [];
         flags = param2;
         var _loc3_:EReg = new EReg("#([ie][A-Za-z0-9_.]+)","");
         var _loc4_:* = 0;
         var _loc5_:* = int(param1.length);
         while(_loc3_.matchSub(param1,_loc4_,_loc5_))
         {
            _loc6_ = _loc3_.matchedPos();
            _loc4_ = int(_loc6_.pos) + int(_loc6_.len);
            _loc5_ = param1.length - _loc4_;
            _loc7_ = new SplitInfo();
            _loc7_.start = int(_loc6_.pos);
            _loc7_.end = int(_loc6_.pos) + int(_loc6_.len);
            _loc7_.keyword = _loc3_.matched(1);
            parts.push(_loc7_);
         }
         if(int(parts.length) == 0)
         {
            return Bytes.ofString(param1);
         }
         _loc3_ = new EReg("[ ]+([A-Za-z0-9_.]+)","");
         var _loc8_:int = 0;
         var _loc9_:int = parts.length;
         while(_loc8_ < _loc9_)
         {
            _loc8_++;
            _loc10_ = _loc8_;
            if(int(parts[_loc10_].keyword.indexOf("if")) != -1)
            {
               if(_loc10_ == int(parts.length) - 1)
               {
                  throw "#End Expected";
               }
               if(_loc3_.matchSub(param1,parts[_loc10_].start,parts[_loc10_ + 1].start - parts[_loc10_].end + 1))
               {
                  parts[_loc10_].flag = _loc3_.matched(1);
                  _loc6_ = _loc3_.matchedPos();
                  parts[_loc10_].end = int(_loc6_.pos) + int(_loc6_.len);
                  continue;
               }
               throw "#if(ifn) Condition Expected";
            }
         }
         output = [];
         add(0);
         var _loc11_:String = "";
         _loc8_ = 0;
         _loc9_ = output.length;
         while(_loc8_ < _loc9_)
         {
            _loc8_++;
            _loc10_ = _loc8_;
            _loc12_ = param1.substring(int(output[_loc10_].start),int(output[_loc10_].end));
            _loc11_ = _loc11_ + _loc12_;
            if(_loc10_ != int(output.length) - 1)
            {
               _loc13_ = output[_loc10_].end;
               _loc14_ = output[_loc10_ + 1].start;
               while(_loc13_ < _loc14_)
               {
                  _loc13_++;
                  _loc15_ = _loc13_;
                  _loc6_ = param1.charCodeAt(_loc15_);
                  if(_loc6_ == 10)
                  {
                     _loc11_ = _loc11_ + "\n";
                  }
               }
               continue;
            }
         }
         return Bytes.ofString(_loc11_);
      }
      
      public function add(param1:int) : int
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
