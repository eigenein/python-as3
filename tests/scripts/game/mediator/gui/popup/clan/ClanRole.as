package game.mediator.gui.popup.clan
{
   import com.progrestar.common.lang.Translate;
   
   public class ClanRole
   {
      
      public static const CODE_MEMBER:int = 2;
      
      public static const CODE_OFFICER:int = 3;
      
      public static const CODE_WARLORD:int = 4;
      
      public static const CODE_LEADER:int = 255;
       
      
      private var source:Object;
      
      private var localeCode:String;
      
      private var _code:int;
      
      private var _permission_disband:Boolean;
      
      private var _permission_edit_banner:Boolean;
      
      private var _permission_edit_title:Boolean;
      
      private var _permission_edit_admin_rank:Boolean;
      
      private var _permission_dismiss_member:Boolean;
      
      private var _permission_dismiss_officer:Boolean;
      
      private var _permission_edit_settings:Boolean;
      
      private var _permission_edit_champion_status:Boolean;
      
      public function ClanRole(param1:Object)
      {
         super();
         this.source = param1;
         localeCode = param1.localeCode;
         _code = param1.code;
         _permission_disband = param1.permission_disband;
         _permission_edit_banner = param1.permission_edit_banner;
         _permission_edit_admin_rank = param1.permission_edit_admin_rank;
         _permission_dismiss_member = param1.permission_dismiss_member;
         _permission_dismiss_officer = param1.permission_dismiss_officer;
         _permission_edit_title = param1.permission_edit_title;
         _permission_edit_settings = param1.permission_edit_title;
         _permission_edit_champion_status = param1.permission_edit_champion_status;
      }
      
      public function get roleName() : String
      {
         return Translate.translate(localeCode);
      }
      
      public function get code() : int
      {
         return _code;
      }
      
      public function get permission_disband() : Boolean
      {
         return _permission_disband;
      }
      
      public function get permission_edit_banner() : Boolean
      {
         return _permission_edit_banner;
      }
      
      public function get permission_edit_title() : Boolean
      {
         return _permission_edit_title;
      }
      
      public function get permission_edit_admin_rank() : Boolean
      {
         return _permission_edit_admin_rank;
      }
      
      public function get permission_dismiss_member() : Boolean
      {
         return _permission_dismiss_member;
      }
      
      public function get permission_dismiss_officer() : Boolean
      {
         return _permission_dismiss_officer;
      }
      
      public function get permission_edit_settings() : Boolean
      {
         return _permission_edit_settings;
      }
      
      public function get permission_edit_champion_status() : Boolean
      {
         return _permission_edit_champion_status;
      }
   }
}
