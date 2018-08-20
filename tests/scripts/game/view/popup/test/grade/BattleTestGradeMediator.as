package game.view.popup.test.grade
{
   public class BattleTestGradeMediator
   {
       
      
      private var clip:BattleTestGradeClip;
      
      private var model:BattleTestGradeModel;
      
      public function BattleTestGradeMediator(param1:BattleTestGradeClip, param2:BattleTestGradeModel)
      {
         var _loc4_:int = 0;
         super();
         this.clip = param1;
         this.model = param2;
         var _loc3_:int = Math.min(param2.properties.length,param1.slider.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            setupSlider(param1.slider[_loc4_],param2.properties[_loc4_]);
            _loc4_++;
         }
      }
      
      protected function setupSlider(param1:BattleGradeSlider, param2:BattleTestGradeProperty) : void
      {
         slider = param1;
         property = param2;
         slider.slider.minimum = property.minValue;
         slider.slider.maximum = property.maxValue;
         slider.slider.step = property.step;
         property.onValue(function(param1:int):void
         {
            slider.slider.value = param1;
            slider.text = property.toString();
         });
         slider.signal_value.add(function(param1:Number):void
         {
            property.value = int(param1);
         });
      }
   }
}
