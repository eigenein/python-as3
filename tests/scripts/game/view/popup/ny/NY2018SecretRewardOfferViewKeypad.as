package game.view.popup.ny
{
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipButton;
   
   public class NY2018SecretRewardOfferViewKeypad extends ClipButton
   {
       
      
      public var letter:Vector.<ClipSprite>;
      
      public function NY2018SecretRewardOfferViewKeypad()
      {
         letter = new Vector.<ClipSprite>();
         super();
      }
      
      public function setData(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = true;
         var _loc2_:int = letter.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            letter[_loc3_].graphics.visible = param1[_loc3_];
            if(!param1[_loc3_])
            {
               _loc4_ = false;
            }
            _loc3_++;
         }
         if(!_loc4_)
         {
            graphics.touchable = false;
         }
      }
   }
}
