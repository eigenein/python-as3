package game.data.storage.tutorial
{
   public class TutorialParams
   {
       
      
      private var data:Object;
      
      public function TutorialParams(param1:Object)
      {
         super();
         this.data = param1;
         if(this.data == null)
         {
            this.data = {};
         }
      }
      
      public function getParameter(param1:String) : *
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(param1.indexOf(".") != -1)
         {
            return data[param1];
         }
         _loc2_ = param1.split(".");
         _loc3_ = data;
         _loc4_ = _loc2_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _loc3_[_loc2_[_loc5_]];
            if(_loc3_ == null)
            {
               return undefined;
            }
            _loc5_++;
         }
         return _loc3_;
      }
   }
}
