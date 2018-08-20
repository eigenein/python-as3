package game.view.popup.hero
{
   import engine.core.clipgui.ClipSprite;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import starling.display.Image;
   
   public class MiniHeroStarDisplay extends LayoutGroup
   {
       
      
      private var starImages:Vector.<ClipSprite>;
      
      private var tintColor:uint = 16777215;
      
      public function MiniHeroStarDisplay()
      {
         starImages = new Vector.<ClipSprite>();
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         layout = _loc1_;
         _loc1_.gap = -3;
      }
      
      public function setValue(param1:int) : void
      {
         var _loc3_:* = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc2_:HorizontalLayout = layout as HorizontalLayout;
         removeChildren();
         if(param1 < 6)
         {
            if(_loc2_)
            {
               _loc2_.paddingTop = 0;
               _loc2_.paddingLeft = 0;
               if(param1 == 5)
               {
                  _loc2_.gap = -3;
               }
               else
               {
                  _loc2_.gap = -2;
               }
            }
            _loc3_ = uint(0);
            while(_loc3_ < param1)
            {
               _loc5_ = AssetStorage.rsx.popup_theme.create(ClipSprite,"starIcon_small");
               starImages[_loc3_] = _loc5_;
               addChild(_loc5_.graphics);
               _loc3_++;
            }
         }
         else
         {
            _loc4_ = new Image(AssetStorage.rsx.popup_theme.getTexture("epic_star_icon_small"));
            if(_loc2_)
            {
               _loc2_.paddingTop = -3;
               _loc2_.paddingLeft = 3;
            }
            addChild(_loc4_);
         }
      }
   }
}
