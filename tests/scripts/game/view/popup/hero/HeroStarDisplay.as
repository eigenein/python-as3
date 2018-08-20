package game.view.popup.hero
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import starling.display.Image;
   
   public class HeroStarDisplay extends LayoutGroup
   {
      
      protected static const INVALIDATION_FLAG_EPIC_STAR:String = "epic_Star";
       
      
      private var size:int = 14;
      
      private var starImages:Vector.<Image>;
      
      private var tintColor:uint = 16777215;
      
      private var alphaEpicStar:Number = 1;
      
      private var epicStar:HeroStarMiddleAnimatedClip;
      
      public function HeroStarDisplay()
      {
         starImages = new Vector.<Image>();
         super();
      }
      
      override public function dispose() : void
      {
         if(epicStar)
         {
            epicStar.dispose();
            epicStar = null;
         }
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         layout = _loc1_;
         _loc1_.gap = -3;
      }
      
      public function set disabled(param1:Boolean) : void
      {
         tintColor = !!param1?7829367:16777215;
         alphaEpicStar = !!param1?0.5:1;
         var _loc4_:int = 0;
         var _loc3_:* = starImages;
         for each(var _loc2_ in starImages)
         {
            _loc2_.color = tintColor;
         }
         if(epicStar)
         {
            epicStar.container.alpha = alphaEpicStar;
         }
      }
      
      public function setValue(param1:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc2_:* = null;
         if(epicStar)
         {
            epicStar.container.removeFromParent();
         }
         removeChildren(0,-1,true);
         if(param1 < 6)
         {
            _loc3_ = layout as HorizontalLayout;
            if(_loc3_)
            {
               if(param1 == 5)
               {
                  _loc3_.gap = -5;
               }
               else
               {
                  _loc3_.gap = -3;
               }
            }
            _loc4_ = uint(0);
            while(_loc4_ < param1)
            {
               _loc2_ = new Image(AssetStorage.rsx.popup_theme.getTexture("starIcon"));
               _loc2_.color = tintColor;
               starImages[_loc4_] = _loc2_;
               addChild(_loc2_);
               _loc4_++;
            }
            if(epicStar)
            {
               epicStar.dispose();
               epicStar = null;
            }
         }
         else
         {
            if(!epicStar)
            {
               epicStar = AssetStorage.rsx.popup_theme.create(HeroStarMiddleAnimatedClip,"epic_star_icon_mid_animated");
               epicStar.container.alpha = alphaEpicStar;
            }
            addChild(epicStar.container);
         }
      }
   }
}
