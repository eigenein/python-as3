package game.view.popup.chestrewardheroeslist
{
   import feathers.core.IToggle;
   import game.assets.storage.AssetStorage;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ChestRewardHeroesListRenderer extends ListItemRenderer implements IToggle
   {
       
      
      private var chestReward:ChestRewardPresentationValueObject;
      
      private var clip:ChestRewardHeroesListRendererClip;
      
      public function ChestRewardHeroesListRenderer()
      {
         super();
      }
      
      override public function set data(param1:Object) : void
      {
         if(data != param1)
         {
            .super.data = param1;
            chestReward = param1 as ChestRewardPresentationValueObject;
            invalidate("data");
         }
      }
      
      override public function get height() : Number
      {
         if(clip)
         {
            return clip.bg.graphics.height;
         }
         return NaN;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ChestRewardHeroesListRendererClip,"chest_reward_hero_list_item");
         addChild(clip.graphics);
         clip.bg.signal_click.add(onClick);
         clip.title_tf.touchable = false;
         clip.hero_view.graphics.touchable = false;
         clip.bg_selected.graphics.touchable = false;
      }
      
      private function onClick() : void
      {
         isSelected = true;
      }
      
      override protected function draw() : void
      {
         if(isInvalid("data") && clip && chestReward)
         {
            clip.title_tf.text = chestReward.item.name;
            clip.hero_view.setData(chestReward);
         }
         if(isInvalid("selected") && clip)
         {
            clip.bg_selected.graphics.visible = isSelected;
         }
         super.draw();
      }
   }
}
