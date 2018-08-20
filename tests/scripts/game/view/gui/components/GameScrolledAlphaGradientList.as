package game.view.gui.components
{
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class GameScrolledAlphaGradientList extends GameScrolledListBase
   {
       
      
      private var _filter:ListAlphaMaskFilter;
      
      protected var _topGradientVisible:Boolean;
      
      protected var _bottomGradientVisible:Boolean;
      
      public function GameScrolledAlphaGradientList(param1:GameScrollBar, param2:Number = 60, param3:Boolean = false)
      {
         super(param1);
         _filter = new ListAlphaMaskFilter(param2,param3);
         filter = new ListAlphaMaskFilter(param2,param3);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      protected function updateGradient(param1:Boolean, param2:Tween, param3:Boolean) : void
      {
         if(!_filter)
         {
            return;
         }
         var _loc4_:Number = !!param3?1:0;
         if(param2)
         {
            param2.reset(_filter,tweenDuration,"linear");
            param2.animate(!!param1?"topGradientAlpha":"bottomGradientAlpha",_loc4_);
            Starling.juggler.add(param2);
         }
         else if(param1)
         {
            _filter.topGradientAlpha = _loc4_;
         }
         else
         {
            _filter.bottomGradientAlpha = _loc4_;
         }
      }
      
      override protected function refreshExternalScrollElements() : void
      {
         if(isTopmostPosition == _topGradientVisible)
         {
            _topGradientVisible = !_topGradientVisible;
            updateGradient(true,tween_top,_topGradientVisible);
         }
         if(isLowestPosition == _bottomGradientVisible)
         {
            _bottomGradientVisible = !_bottomGradientVisible;
            updateGradient(false,tween_bottom,_bottomGradientVisible);
         }
      }
   }
}
