package game.battle
{
   public class RandomSequence
   {
      
      private static const MAT1:uint = 1886417008;
      
      private static const MAT2:uint = 117901063;
      
      private static const TMAT:uint = 1431655765;
      
      protected static const MIN_LOOP:int = 8;
      
      protected static const PRE_LOOP:int = 8;
       
      
      private var _seed:uint;
      
      private var _numbersGenerated:int;
      
      private var s0:uint;
      
      private var s1:uint;
      
      private var s2:uint;
      
      private var s3:uint;
      
      public function RandomSequence(param1:uint = 42)
      {
         super();
         this.seed = param1;
      }
      
      public final function get seed() : uint
      {
         return _seed;
      }
      
      public final function set seed(param1:uint) : void
      {
         var _loc2_:int = 0;
         _seed = param1;
         _numbersGenerated = 0;
         s0 = _seed;
         s1 = 1886417008;
         s2 = 117901063;
         s3 = 1431655765;
         s1 = s1 ^ 1 + 2305097728 * (s0 >>> 16) + 1812433253 * ((s0 ^ s0 >>> 30) & 65535);
         s2 = s2 ^ 2 + 2305097728 * (s1 >>> 16) + 1812433253 * ((s1 ^ s1 >>> 30) & 65535);
         s3 = s3 ^ 3 + 2305097728 * (s2 >>> 16) + 1812433253 * ((s2 ^ s2 >>> 30) & 65535);
         s0 = s0 ^ 4 + 2305097728 * (s3 >>> 16) + 1812433253 * ((s3 ^ s3 >>> 30) & 65535);
         s1 = s1 ^ 5 + 2305097728 * (s0 >>> 16) + 1812433253 * ((s0 ^ s0 >>> 30) & 65535);
         s2 = s2 ^ 6 + 2305097728 * (s1 >>> 16) + 1812433253 * ((s1 ^ s1 >>> 30) & 65535);
         s3 = s3 ^ 7 + 2305097728 * (s2 >>> 16) + 1812433253 * ((s2 ^ s2 >>> 30) & 65535);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            nextState();
            _loc2_++;
         }
      }
      
      public final function get period() : uint
      {
         return 4294967295;
      }
      
      public final function get numbersGenerated() : int
      {
         return _numbersGenerated;
      }
      
      public function current() : uint
      {
         return generateValue();
      }
      
      public function next() : uint
      {
         nextState();
         return generateValue();
      }
      
      public function nextNumber() : Number
      {
         nextState();
         return generateValue() / 4294967295;
      }
      
      public function generateInt(param1:int, param2:int) : int
      {
         var _loc7_:* = 0;
         var _loc4_:* = 0;
         var _loc3_:* = 0;
         var _loc8_:uint = param2 - param1 + 1;
         var _loc5_:int = 4294967295;
         if(_loc8_ <= 0)
         {
            throw new ArgumentError("Range is too small");
         }
         if(_loc8_ - 1 > _loc5_)
         {
            throw new ArgumentError("Range is too wide");
         }
         var _loc6_:uint = _loc5_ - (_loc5_ + 1) % _loc8_;
         do
         {
            _loc7_ = uint(s0 & 2147483647 ^ s1 ^ s2);
            _loc7_ = uint(_loc7_ ^ _loc7_ << 1);
            s3 = s3 ^ (s3 >>> 1 ^ _loc7_);
            s0 = s1;
            s1 = -(s3 & 1) & 1886417008 ^ s2;
            s2 = -(s3 & 1) & 117901063 ^ _loc7_ ^ s3 << 10;
            _numbersGenerated = Number(_numbersGenerated) + 1;
            _loc4_ = uint(s0 ^ s2 >>> 8);
            _loc3_ = uint(s3 ^ _loc4_ ^ -(_loc4_ & 1) & 1431655765);
         }
         while(_loc3_ > _loc6_);
         
         return param1 + _loc3_ % _loc8_;
      }
      
      private final function nextState() : void
      {
         var _loc1_:uint = s0 & 2147483647 ^ s1 ^ s2;
         _loc1_ = _loc1_ ^ _loc1_ << 1;
         s3 = s3 ^ (s3 >>> 1 ^ _loc1_);
         s0 = s1;
         s1 = -(s3 & 1) & 1886417008 ^ s2;
         s2 = -(s3 & 1) & 117901063 ^ _loc1_ ^ s3 << 10;
         _numbersGenerated = Number(_numbersGenerated) + 1;
      }
      
      private final function generateValue() : uint
      {
         var _loc1_:uint = s0 ^ s2 >>> 8;
         return s3 ^ _loc1_ ^ -(_loc1_ & 1) & 1431655765;
      }
      
      private function safeUIntMultiply(param1:uint, param2:uint) : uint
      {
         return (param1 & 65535) * (param2 & 65535) + ((param1 >>> 16 & 65535) * (param2 & 65535) + (param2 >>> 16 & 65535) * (param1 & 65535) << 16);
      }
      
      private function safeUIntMultiply1812433253(param1:uint) : uint
      {
         return 2305097728 * (s0 >>> 16) + 1812433253 * ((s0 ^ s0 >>> 32) & 65535);
      }
   }
}
