package game.mediator.gui.popup.billing.bundle
{
   import engine.core.clipgui.ClipAnimatedContainer;
   
   public class BundleListItemContainersClip extends ClipAnimatedContainer
   {
       
      
      private var _itemCount:int;
      
      public const item:Vector.<BundleListItemContainerAnimation> = new Vector.<BundleListItemContainerAnimation>();
      
      public function BundleListItemContainersClip()
      {
         super();
      }
      
      public function setMajorItemsCount(param1:int) : void
      {
         _itemCount = param1;
         if(param1 == 3)
         {
            playback.gotoAndStop(0);
         }
         else if(param1 == 4)
         {
            playback.gotoAndStop(1);
         }
         else if(param1 == 5)
         {
            playback.gotoAndStop(2);
         }
         else
         {
            playback.gotoAndStop(0);
         }
      }
      
      public function setMinorItemsCount(param1:int) : void
      {
         _itemCount = param1;
         if(param1 == 1)
         {
            playback.gotoAndStop(3);
         }
         else if(param1 == 2)
         {
            playback.gotoAndStop(4);
         }
         else
         {
            playback.gotoAndStop(0);
         }
      }
      
      public function playHoverAnimation() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Number = NaN;
         var _loc3_:int = Math.min(_itemCount,item.length);
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(item[_loc2_].playback.isPlaying)
            {
               return;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_ = 0.05 * _loc2_;
            if(_loc2_ < _loc3_ * 0.3)
            {
               item[_loc2_].playShake(_loc1_);
            }
            else
            {
               item[_loc2_].playJump(_loc1_);
            }
            _loc2_++;
         }
      }
   }
}
