package game.view.popup.rating
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class RatingPopupPlayerDeltaClip extends GuiClipNestedContainer
   {
       
      
      public var tf_place_down:ClipLabel;
      
      public var tf_place_up:ClipLabel;
      
      public var arrow_down:ClipSprite;
      
      public var arrow_up:ClipSprite;
      
      public var layout_delta:ClipLayout;
      
      public function RatingPopupPlayerDeltaClip()
      {
         tf_place_down = new ClipLabel(true);
         tf_place_up = new ClipLabel(true);
         arrow_down = new ClipSprite();
         arrow_up = new ClipSprite();
         layout_delta = ClipLayout.horizontalRight(4,arrow_down,arrow_up,tf_place_down,tf_place_up);
         super();
      }
      
      public function commitData(param1:int) : void
      {
         var _loc2_:* = param1 < 0;
         arrow_down.graphics.visible = _loc2_;
         tf_place_down.visible = _loc2_;
         _loc2_ = param1 > 0;
         arrow_up.graphics.visible = _loc2_;
         tf_place_up.visible = _loc2_;
         if(param1)
         {
            _loc2_ = String(param1);
            tf_place_up.text = _loc2_;
            tf_place_down.text = _loc2_;
         }
      }
   }
}
