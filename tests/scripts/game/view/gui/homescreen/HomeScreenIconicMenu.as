package game.view.gui.homescreen
{
   import com.progrestar.common.lang.Translate;
   import engine.core.animation.SkinnableAnimation;
   import engine.core.clipgui.GuiClipFactory;
   import feathers.textures.Scale3Textures;
   import game.assets.storage.RsxGameAsset;
   import game.mediator.gui.homescreen.HomeScreenIconicMenuMediator;
   import game.view.gui.components.GameButton;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class HomeScreenIconicMenu extends Sprite implements ITutorialActionProvider
   {
       
      
      private var mediator:HomeScreenIconicMenuMediator;
      
      private var red_point_hero:Image;
      
      private var red_point_friends:Image;
      
      private var asset:RsxGameAsset;
      
      private var menu:SkinnableAnimation;
      
      private var label_bg_texture:Scale3Textures;
      
      private var clip:HomeScreenIconicMenuGuiClip;
      
      public function HomeScreenIconicMenu(param1:HomeScreenIconicMenuMediator)
      {
         super();
         this.mediator = param1;
         addEventListener("addedToStage",handler_addedToStage);
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addButton(TutorialNavigator.INVENTORY,clip.btn_inventory);
         _loc2_.addButton(TutorialNavigator.QUESTS,clip.btn_quest);
         _loc2_.addButton(TutorialNavigator.HEROES,clip.btn_hero);
         _loc2_.addButton(TutorialNavigator.CHART,clip.btn_rating);
         _loc2_.addButton(TutorialNavigator.FRIENDS,clip.btn_friends);
         return _loc2_;
      }
      
      protected function handler_addedToStage() : void
      {
         removeEventListener("addedToStage",handler_addedToStage);
         var _loc1_:GuiClipFactory = new GuiClipFactory();
         clip = new HomeScreenIconicMenuGuiClip();
         _loc1_.create(clip,HomeScreenStyle.asset.data.getClipByName("main_menu"));
         addChild(clip.graphics);
         clip.btn_inventory.redMarkerState = mediator.redMarkerMediator.inventory;
         clip.btn_inventory.label = Translate.translate("UI_MAINMENU_INVENTORY");
         clip.btn_inventory.signal_click.add(mediator.action_clickInventory);
         clip.btn_quest.redMarkerState = mediator.redMarkerMediator.quest;
         clip.btn_quest.label = Translate.translate("UI_MAINMENU_QUESTS");
         clip.btn_quest.signal_click.add(mediator.action_clickQuests);
         clip.btn_hero.redMarkerState = mediator.redMarkerMediator.hero;
         clip.btn_hero.label = Translate.translate("UI_MAINMENU_HEROES");
         clip.btn_hero.signal_click.add(mediator.action_clickHeroes);
         clip.btn_rating.label = Translate.translate("UI_MAINMENU_CHART");
         clip.btn_rating.signal_click.add(mediator.action_clickRating);
         clip.btn_friends.redMarkerState = mediator.redMarkerMediator.friends;
         clip.btn_friends.label = Translate.translate("UI_MAINMENU_FRIENDS");
         clip.btn_friends.signal_click.add(mediator.action_clickFriends);
         Tutorial.addActionsFrom(this);
      }
      
      private function createButton(param1:Texture, param2:Boolean = false) : GameButton
      {
         var _loc3_:GameButton = new GameButton();
         var _loc4_:* = new Image(param1);
         _loc3_.downSkin = _loc4_;
         _loc3_.upSkin = _loc4_;
         _loc3_.hoverSkin = new Image(param1);
         _loc3_.hoverSkin.alpha = 0.8;
         if(!param2)
         {
            _loc4_ = 0.75;
            _loc3_.scaleY = _loc4_;
            _loc3_.scaleX = _loc4_;
         }
         return _loc3_;
      }
   }
}
