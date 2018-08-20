package game.data.storage
{
   public class NicknameStorage
   {
       
      
      private var pre_1:Array;
      
      private var suf_1:Array;
      
      private var pre_2:Array;
      
      private var suf_2:Array;
      
      public function NicknameStorage()
      {
         pre_1 = [];
         suf_1 = [];
         pre_2 = [];
         suf_2 = [];
         super();
      }
      
      public function init(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = param1[_loc3_];
            if(_loc2_.pre_1)
            {
               pre_1.push(_loc2_.pre_1);
            }
            if(_loc2_.pre_2)
            {
               pre_2.push(_loc2_.pre_2);
            }
            if(_loc2_.suf_1)
            {
               suf_1.push(_loc2_.suf_1);
            }
            if(_loc2_.suf_2)
            {
               suf_2.push(_loc2_.suf_2);
            }
         }
      }
      
      public function getRandomNickname() : String
      {
         return pre_1[rnd(pre_1.length)] + suf_1[rnd(suf_1.length)];
      }
      
      public function getNicknameBySeed(param1:int) : String
      {
         var _loc2_:int = param1 % pre_1.length;
         var _loc3_:int = (param1 + 255) % suf_1.length;
         return pre_1[_loc2_] + suf_1[_loc3_];
      }
      
      private function rnd(param1:int) : int
      {
         return int(Math.random() * param1);
      }
   }
}
