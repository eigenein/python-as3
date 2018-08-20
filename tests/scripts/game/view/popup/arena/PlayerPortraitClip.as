package game.view.popup.arena
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.INeedNestedParsing;
   import game.data.storage.DataStorage;
   import game.data.storage.playeravatar.PlayerAvatarDescription;
   import game.model.user.UserInfo;
   import game.view.gui.components.AvatarDescRenderer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class PlayerPortraitClip extends ClipButton implements INeedNestedParsing
   {
       
      
      private var default_tf_level_position:Number = 0;
      
      private var doNotShowLeagueFrame:Boolean;
      
      public var portrait:AvatarDescRenderer;
      
      public var tf_level:ClipLabel;
      
      public var tf_label_nickname:ClipLabel;
      
      public var frame:GuiAnimation;
      
      public var level_plate:GuiAnimation;
      
      public function PlayerPortraitClip(param1:Boolean = false)
      {
         portrait = new AvatarDescRenderer();
         tf_label_nickname = new ClipLabel();
         frame = new GuiAnimation();
         super();
         isEnabled = false;
         this.doNotShowLeagueFrame = param1;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(tf_level)
         {
            default_tf_level_position = tf_level.x;
         }
      }
      
      public function setAvatarDescriptionOnly(param1:PlayerAvatarDescription) : void
      {
         portrait.data = param1;
         var _loc2_:int = 0;
         frame.gotoAndStop(_loc2_);
         if(level_plate)
         {
            level_plate.gotoAndStop(_loc2_);
         }
      }
      
      public function setFrameAndLevel(param1:UserInfo) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _loc2_ = param1.frameId;
            if(doNotShowLeagueFrame)
            {
               _loc2_ = 0;
            }
            setLevel(param1.level);
            tf_label_nickname.text = param1.nickname;
            if(level_plate)
            {
               level_plate.graphics.visible = true;
            }
            if(tf_level)
            {
               tf_level.visible = true;
            }
         }
         else
         {
            _loc2_ = 0;
            if(level_plate)
            {
               level_plate.graphics.visible = false;
            }
            if(tf_level)
            {
               tf_level.visible = false;
            }
         }
         frame.gotoAndStop(_loc2_);
         if(level_plate)
         {
            level_plate.gotoAndStop(_loc2_);
         }
      }
      
      public function setLevel(param1:int) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = false;
         if(tf_level)
         {
            _loc2_ = String(param1);
            tf_level.text = _loc2_;
            _loc3_ = _loc2_.charAt(0) == "1";
            tf_level.x = !!_loc3_?default_tf_level_position - 1:Number(default_tf_level_position);
         }
      }
      
      public function setData(param1:UserInfo) : void
      {
         setFrameAndLevel(param1);
         portrait.data = DataStorage.playerAvatar.getAvatarById(!!param1?param1.avatarId:1);
      }
   }
}
