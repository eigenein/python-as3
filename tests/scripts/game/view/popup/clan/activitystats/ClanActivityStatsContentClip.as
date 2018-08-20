package game.view.popup.clan.activitystats
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.data.ListCollection;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.clan.activitystats.ClanActivityStatsPopupMediator;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanActivityStatsContentClip extends GuiClipNestedContainer
   {
       
      
      private var mediator:ClanActivityStatsPopupMediator;
      
      private var list:GameScrolledList;
      
      public var tf_label_desc:ClipLabel;
      
      public var like_activity:ClipSprite;
      
      public var like_dungeonActivity:ClipSprite;
      
      public var layout_desc:ClipLayout;
      
      public var tf_player:ClipLabel;
      
      public var tf_gifts:ClipLabel;
      
      public var column_total:ClanActivityStatsColumnHeaderClip;
      
      public var column_day_:Vector.<ClanActivityStatsColumnHeaderClip>;
      
      public var list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function ClanActivityStatsContentClip()
      {
         tf_label_desc = new ClipLabel(true);
         like_activity = new ClipSprite();
         like_dungeonActivity = new ClipSprite();
         layout_desc = ClipLayout.horizontalMiddleCentered(5,tf_label_desc,like_dungeonActivity,like_activity);
         tf_player = new ClipLabel();
         tf_gifts = new ClipLabel();
         column_total = new ClanActivityStatsColumnHeaderClip();
         column_day_ = new Vector.<ClanActivityStatsColumnHeaderClip>();
         list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < column_day_.length)
         {
            column_day_[_loc1_].signal_click.remove(handler_columnHeaderSelect);
            column_day_[_loc1_].dispose();
            _loc1_++;
         }
         column_total.signal_click.remove(handler_columnHeaderSelect);
         column_total.dispose();
      }
      
      public function update() : void
      {
         if(!mediator)
         {
            return;
         }
         handler_columnHeaderSelect(column_total);
         updateColumnHeaderLabels();
      }
      
      public function initialize(param1:ClanActivityStatsPopupMediator) : void
      {
         this.mediator = param1;
         tf_label_desc.text = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_DESCRIPTION");
         tf_gifts.text = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_GIFTS_RECEIVED");
         tf_player.text = Translate.translate("DEFAULT_NICKNAME");
         initializeColumnHeaders();
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = scroll_slider_container.container.height;
         scroll_slider_container.container.addChild(_loc2_);
         list = new GameScrolledList(_loc2_,null,null);
         list.layout = new VerticalLayout();
         (list.layout as VerticalLayout).paddingTop = 2;
         (list.layout as VerticalLayout).paddingBottom = 2;
         (list.layout as VerticalLayout).gap = 9;
         list.width = list_container.container.width;
         list.height = list_container.container.height;
         list.itemRendererType = ClanActivityStatsRenderer;
         list_container.container.addChild(list);
         update();
      }
      
      private function initializeColumnHeaders() : void
      {
         var _loc1_:int = 0;
         column_total.tf_name.text = Translate.translate("UI_DIALOG_CLAN_ACTIVITY_TOTAL");
         column_total.signal_click.add(handler_columnHeaderSelect);
         _loc1_ = 0;
         while(_loc1_ < column_day_.length)
         {
            column_day_[_loc1_].signal_click.add(handler_columnHeaderSelect);
            _loc1_++;
         }
      }
      
      private function updateColumnHeaderLabels() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < column_day_.length)
         {
            column_day_[_loc1_].tf_name.text = mediator.days[_loc1_];
            _loc1_++;
         }
      }
      
      private function handler_columnHeaderSelect(param1:ClanActivityStatsColumnHeaderClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         column_total.icon.graphics.visible = false;
         _loc2_ = 0;
         while(_loc2_ < column_day_.length)
         {
            column_day_[_loc2_].icon.graphics.visible = false;
            _loc2_++;
         }
         param1.icon.graphics.visible = true;
         if(param1 == column_total)
         {
            _loc3_ = -1;
         }
         else
         {
            _loc3_ = column_day_.indexOf(param1);
         }
         if(mediator.selectedTab == "tab_clan_points")
         {
            like_activity.graphics.visible = true;
            like_dungeonActivity.graphics.visible = false;
            mediator.action_sortClanActivityList(_loc3_);
            list.dataProvider = new ListCollection(mediator.listData_activity);
         }
         else if(mediator.selectedTab == "tab_titanit")
         {
            like_activity.graphics.visible = false;
            like_dungeonActivity.graphics.visible = true;
            mediator.action_sortDungeonActivityList(_loc3_);
            list.dataProvider = new ListCollection(mediator.listData_dungeonActivity);
         }
      }
   }
}
