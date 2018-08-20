package game.view.gui.components.hero
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.DataClipButton;
   
   public class MiniHeroPortraitClip extends DataClipButton
   {
       
      
      protected var _data:UnitEntryValueObject;
      
      public var image_frame:GuiClipImage;
      
      public var image_item:GuiClipImage;
      
      public var image_bg:GuiClipImage;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_4:ClipSprite;
      
      public var star_5:ClipSprite;
      
      public var epic_star:ClipSprite;
      
      public var layout_stars:ClipLayout;
      
      public function MiniHeroPortraitClip()
      {
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_4 = new ClipSprite();
         star_5 = new ClipSprite();
         epic_star = new ClipSprite();
         layout_stars = ClipLayout.horizontalMiddleCentered(-4,star_1,star_2,star_3,star_4,star_5,epic_star);
         super(UnitEntryValueObject);
      }
      
      public function set data(param1:UnitEntryValueObject) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         this._data = param1;
         if(!param1)
         {
            graphics.visible = false;
            return;
         }
         graphics.visible = true;
         image_bg.image.texture = param1.qualityBackground;
         image_frame.image.texture = param1.qualityFrame_small;
         image_item.image.texture = param1.icon;
         _loc3_ = 1;
         while(_loc3_ < 6)
         {
            _loc2_ = this["star_" + _loc3_];
            if(_loc2_)
            {
               _loc2_.graphics.visible = _loc3_ <= param1.starCount && param1.starCount < 6;
            }
            _loc3_++;
         }
         epic_star.graphics.visible = param1.starCount == 6;
      }
      
      override protected function getClickData() : *
      {
         return _data;
      }
   }
}
