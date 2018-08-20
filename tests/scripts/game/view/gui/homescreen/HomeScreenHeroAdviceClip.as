package game.view.gui.homescreen
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.view.gui.QuestHeroAdviceValueObject;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabelNoFilter;
   import game.view.gui.components.ClipLayout;
   import starling.core.Starling;
   
   public class HomeScreenHeroAdviceClip extends ClipButton
   {
       
      
      public var tf_subject:ClipLabelNoFilter;
      
      public var tf_quest:ClipLabelNoFilter;
      
      public var arrow:ClipSprite;
      
      public var quest_icon:GuiClipImage;
      
      public var text_layout:ClipLayout;
      
      private var advice:QuestHeroAdviceValueObject;
      
      public function HomeScreenHeroAdviceClip()
      {
         tf_subject = new ClipLabelNoFilter();
         tf_quest = new ClipLabelNoFilter();
         arrow = new ClipSprite();
         quest_icon = new GuiClipImage();
         text_layout = ClipLayout.verticalMiddleLeft(3,tf_subject,tf_quest);
         super();
      }
      
      public function setData(param1:QuestHeroAdviceValueObject) : void
      {
         this.advice = param1;
         tf_subject.text = param1.text;
         var _loc2_:PlayerQuestValueObject = new PlayerQuestValueObject(param1.quest,false);
         signal_click.add(handler_click);
         quest_icon.image.texture = AssetStorageUtil.getItemDescTexture(param1.hero);
         tf_quest.text = param1.questText;
         graphics.scaleX = 0.2;
         graphics.scaleY = 0.2;
         graphics.alpha = 0;
         Starling.juggler.tween(graphics,0.4,{
            "transition":"easeOutBack",
            "delay":0,
            "scaleX":1,
            "scaleY":1,
            "alpha":1
         });
      }
      
      public function animateHide() : void
      {
         Starling.juggler.tween(graphics,0.2,{
            "transition":"linear",
            "delay":0,
            "scaleX":0.2,
            "scaleY":0.2,
            "alpha":0,
            "onComplete":handler_tweenHideComplete
         });
      }
      
      private function handler_tweenHideComplete() : void
      {
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
      }
      
      private function handler_click() : void
      {
         var _loc1_:* = null;
         if(advice.advice.requirement_skillsNotMaxed)
         {
            if(advice.hero is HeroDescription)
            {
               PopupList.instance.dialog_hero(advice.hero as HeroDescription);
            }
            return;
         }
         if(advice.advice.requirement_mechanicIdent == MechanicStorage.GRAND.type)
         {
            Game.instance.navigator.navigateToMechanic(MechanicStorage.GRAND,_loc1_);
            return;
         }
         _loc1_ = new PopupStashEventParams();
         _loc1_.windowName = "global";
         _loc1_.buttonName = "hero_advice";
         Game.instance.navigator.questHelper.helpWithQuest(advice.quest,_loc1_);
      }
   }
}
