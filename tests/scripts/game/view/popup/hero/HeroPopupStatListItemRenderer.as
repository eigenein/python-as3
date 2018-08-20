package game.view.popup.hero
{
   import feathers.controls.LayoutGroup;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.BattleStatValueObject;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class HeroPopupStatListItemRenderer extends LayoutGroup
   {
       
      
      private var clip:HeroPopupStatListItemRendererClip;
      
      private var value:BattleStatValueObject;
      
      public function HeroPopupStatListItemRenderer()
      {
         super();
      }
      
      public function set data(param1:BattleStatValueObject) : void
      {
         this.value = param1;
         invalidate("data");
      }
      
      override protected function draw() : void
      {
         var _loc2_:* = null;
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid("data"))
         {
            _loc2_ = value.name + ": " + ColorUtils.hexToRGBFormat(16383999) + value.value;
            clip.tf_label.text = _loc2_;
            _loc1_ = clip.tf_label.height;
            invalidate("size");
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(HeroPopupStatListItemRendererClip,"hero_dialog_stat_list_renderer");
         addChild(clip.tf_label);
      }
   }
}
