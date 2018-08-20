package game.view.gui.tutorial.condition
{
   import game.data.cost.CostData;
   
   public class TutorialLibCondition extends TutorialCondition
   {
       
      
      private var _params:Array;
      
      public function TutorialLibCondition(param1:String, param2:String)
      {
         var _loc3_:* = undefined;
         if(param2)
         {
            if(param1 == "hasEnough")
            {
               _loc3_ = new CostData(JSON.parse(param2));
               _params = [_loc3_];
            }
            else
            {
               _params = param2.split(",");
               _loc3_ = _params[0];
            }
         }
         else
         {
            _params = null;
            _loc3_ = null;
         }
         super(param1,_loc3_);
      }
      
      public function get params() : Array
      {
         return _params;
      }
      
      public function hasParam(param1:*) : Boolean
      {
         return _params && _params.indexOf(param1) != -1;
      }
      
      override public function triggerIfEqual(param1:*) : void
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
