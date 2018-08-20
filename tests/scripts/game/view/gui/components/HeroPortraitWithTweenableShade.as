package game.view.gui.components
{
   import starling.core.Starling;
   
   public class HeroPortraitWithTweenableShade extends HeroPortrait
   {
       
      
      private var _shadingDisabledProgress:Number = 1;
      
      private var defaultX:Number;
      
      private var defaultY:Number;
      
      public function HeroPortraitWithTweenableShade()
      {
         super();
      }
      
      public function get shadingDisabledProgress() : Number
      {
         return _shadingDisabledProgress;
      }
      
      public function set shadingDisabledProgress(param1:Number) : void
      {
         _shadingDisabledProgress = param1;
         param1 = param1 * param1;
         var _loc2_:* = (int(51 + 204 * param1)) * 65793;
         levelLabelBg.color = _loc2_;
         _loc2_ = _loc2_;
         _icon.color = _loc2_;
         _loc2_ = _loc2_;
         frame.color = _loc2_;
         background.color = _loc2_;
         _loc2_ = 0.5 + (1 - 0.5) * param1;
         levelLabel.alpha = _loc2_;
         starDisplay.alpha = _loc2_;
      }
      
      public function popOut() : void
      {
         Starling.juggler.removeTweens(this);
         if(defaultX !== defaultX)
         {
            defaultX = x;
            defaultY = y;
         }
         var _loc1_:* = 1.1;
         x = defaultX - width * (_loc1_ - 1) * 0.5;
         y = defaultY - height * (_loc1_ - 1) * 0.5;
         scaleY = _loc1_;
         scaleX = _loc1_;
         Starling.juggler.tween(this,0.15,{
            "scaleX":1,
            "scaleY":1,
            "x":defaultX,
            "y":defaultY,
            "transition":"easeOut"
         });
      }
   }
}
