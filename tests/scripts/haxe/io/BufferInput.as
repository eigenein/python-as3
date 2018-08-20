package haxe.io
{
   public class BufferInput extends Input
   {
       
      
      public var pos:int;
      
      public var i:Input;
      
      public var buf:Bytes;
      
      public var available:int;
      
      public function BufferInput()
      {
      }
      
      public function refill() : void
      {
         if(pos > 0)
         {
            buf.blit(0,buf,pos,available);
            pos = 0;
         }
         available = available + int(i.readBytes(buf,available,buf.length - available));
      }
      
      override public function readBytes(param1:Bytes, param2:int, param3:int) : int
      {
         var _loc4_:int = 0;
         if(available == 0)
         {
            refill();
         }
         if(param3 > available)
         {
            _loc4_ = available;
         }
         else
         {
            _loc4_ = param3;
         }
         param1.blit(param2,buf,pos,_loc4_);
         pos = pos + _loc4_;
         available = available - _loc4_;
         return _loc4_;
      }
      
      override public function readByte() : int
      {
         if(available == 0)
         {
            refill();
         }
         var _loc1_:int = buf.b[pos];
         pos = pos + 1;
         available = available - 1;
         return _loc1_;
      }
   }
}
