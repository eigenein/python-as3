package game.view.popup.quest
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.quest.QuestDescription;
   import game.model.user.quest.PlayerQuestEntry;
   import game.model.user.quest.PlayerQuestValueObject;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import idv.cjcat.signals.Signal;
   import starling.display.Image;
   
   public class QuestListItemRenderer extends ListItemRenderer implements ITutorialActionProvider
   {
       
      
      private var image:Image;
      
      private var clip:QuestListItemClip;
      
      private var _signal_select:Signal;
      
      private var _signal_farm:Signal;
      
      private var label_questReward:GameLabel;
      
      public function QuestListItemRenderer()
      {
         super();
         _signal_select = new Signal(PlayerQuestValueObject);
         _signal_farm = new Signal(PlayerQuestValueObject);
      }
      
      override public function dispose() : void
      {
         data = null;
         Tutorial.removeActionsFrom(this);
         if(clip)
         {
            clip.dispose();
         }
         super.dispose();
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_farm() : Signal
      {
         return _signal_farm;
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:PlayerQuestValueObject = data as PlayerQuestValueObject;
         if(_loc2_)
         {
            _loc2_.signal_progressUpdate.remove(handler_dataUpdate);
         }
         .super.data = param1;
         _loc2_ = data as PlayerQuestValueObject;
         if(_loc2_)
         {
            _loc2_.signal_progressUpdate.add(handler_dataUpdate);
         }
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc3_:* = null;
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         if(data)
         {
            _loc3_ = DataStorage.quest.getQuestById((data as PlayerQuestValueObject).id);
            _loc2_.addButtonWithKey(TutorialNavigator.ACTION_QUEST_FARM,clip.button_finish,_loc3_);
            _loc2_.addButtonWithKey(TutorialNavigator.ACTION_QUEST_GO,clip.button_go,_loc3_);
         }
         return _loc2_;
      }
      
      override protected function commitData() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         super.commitData();
         var _loc2_:PlayerQuestValueObject = data as PlayerQuestValueObject;
         if(_loc2_)
         {
            clip.label_questTask.text = _loc2_.taskDescription;
            image.texture = _loc2_.questIconTexture;
            _loc1_ = clip.reward_items.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(_loc2_.rewards && _loc2_.rewards.length > _loc3_)
               {
                  clip.reward_items[_loc3_].data = _loc2_.rewards[_loc3_];
               }
               else
               {
                  clip.reward_items[_loc3_].data = null;
               }
               _loc3_++;
            }
            commitProgressData();
         }
         Tutorial.addActionsFrom(this);
      }
      
      protected function commitProgressData() : void
      {
         var _loc1_:PlayerQuestValueObject = data as PlayerQuestValueObject;
         if(!_loc1_)
         {
            return;
         }
         if(clip.bg.graphics)
         {
            clip.label_questProgress.text = _loc1_.progressCurrent + "/" + _loc1_.progressMax;
            clip.button_finish.graphics.visible = _loc1_.canFarm;
            clip.button_go.graphics.visible = _loc1_.hasNavigator && !_loc1_.canFarm;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_dialog_quest_list_item();
         addChild(clip.graphics);
         image = new Image(AssetStorage.rsx.popup_theme.missing_texture);
         var _loc1_:int = 72;
         image.height = _loc1_;
         image.width = _loc1_;
         clip.item_container.container.addChild(image);
         clip.button_finish.label = Translate.translate("UI_DIALOG_QUEST_FARM");
         clip.button_go.label = Translate.translate("UI_DIALOG_QUEST_INFO");
         clip.button_finish.signal_click.add(buttonClickFarm);
         clip.button_go.signal_click.add(buttonClickInfo);
      }
      
      private function buttonClick() : void
      {
      }
      
      private function buttonClickFarm() : void
      {
         _signal_farm.dispatch(data as PlayerQuestValueObject);
      }
      
      private function buttonClickInfo() : void
      {
         _signal_select.dispatch(data as PlayerQuestValueObject);
      }
      
      private function handler_dataUpdate(param1:PlayerQuestEntry) : void
      {
         commitProgressData();
      }
   }
}
