procedure render_timedropper (
  p_item   in            apex_plugin.t_item,
  p_plugin in            apex_plugin.t_plugin,
  p_param  in            apex_plugin.t_item_render_param,
  p_result in out nocopy apex_plugin.t_item_render_result )
is
  l_autoswitch           boolean;
  l_meridians            boolean;
  l_format               varchar2(7);
  l_mousewheel           boolean;
  l_init_animation       varchar2(8);
  l_set_current_time     boolean;
  l_primary_color        varchar2(7);
  l_text_color           varchar2(7);
  l_background_color     varchar2(7);
  l_border_color         varchar2(7);
  l_theme                varchar2(10);
  l_html                 varchar2(4000);
  l_options              varchar2(4000);
  --
  --Convert Yes/No To True/False BOOLEAN Type
  --
  function yn_to_tf ( p_yn  in varchar2 )
  return boolean
  is
  begin
    case when lower(p_yn) = 'y' then return true;
    else return false;
    end case;
  end yn_to_tf;
begin
  --
  --Component-Level Custom Attributes
  --
  l_set_current_time  := yn_to_tf(p_item.attribute_01);
  --
  --Application-Level Custom Attributes
  --
  l_autoswitch        := yn_to_tf(p_plugin.attribute_01);
  l_meridians         := yn_to_tf(p_plugin.attribute_02);
  l_format            := p_plugin.attribute_03;
  l_mousewheel        := yn_to_tf(p_plugin.attribute_04);
  l_init_animation    := p_plugin.attribute_05;
  l_theme             := p_plugin.attribute_06;
  --
  --Add Theme CSS Files
  --
  case l_theme
    when 'vita_dark' then
      l_primary_color     := '#e6e6e6';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#262629';
    when 'vita_red' then
      l_primary_color     := '#da1b1b';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#c31818';
    when 'vita_slate' then
      l_primary_color     := '#505f6d';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#45525e';
    else
      l_primary_color     := '#0572ce';
      l_text_color        := '#4d4d4d';
      l_background_color  := '#ffffff';
      l_border_color      := '#0465b5';
  end case;
  --
  --Debug Mode
  --
  if apex_application.g_debug then
    apex_plugin_util.debug_page_item (
      p_plugin              => p_plugin,
      p_page_item           => p_item,
      p_value               => p_param.value,
      p_is_readonly         => p_param.is_readonly,
      p_is_printer_friendly => p_param.is_printer_friendly );
  end if;
  --
  --Printer Friendly Display
  --
  if p_param.is_printer_friendly then
    apex_plugin_util.print_display_only (
      p_item_name           => p_item.name,
      p_display_value       => p_param.value,
      p_show_line_breaks    => false,
      p_escape              => true,
      p_attributes          => p_item.element_attributes );

    p_result.is_navigable := false;
  --
  --Read Only Display
  --
  elsif p_param.is_readonly then
    apex_plugin_util.print_hidden_if_readonly (
      p_item_name           => p_item.name,
      p_value               => p_param.value,
      p_is_readonly         => p_param.is_readonly,
      p_is_printer_friendly => p_param.is_printer_friendly );

    p_result.is_navigable := false;
  else
    l_html := '<input type="text" id="' || p_item.id || '" />';

    sys.htp.p(l_html);

    apex_javascript.add_onload_code (
      p_code => '$("#' || p_item.id || '").timeDropper({'                                                 ||
        apex_javascript.add_attribute('autoswitch'     , l_autoswitch)                                    ||
        apex_javascript.add_attribute('meridians'      , l_meridians)                                     ||
        apex_javascript.add_attribute('format'         , sys.htf.escape_sc(l_format))                     ||
        apex_javascript.add_attribute('mousewheel'     , l_mousewheel)                                    ||
        apex_javascript.add_attribute('init_animation' , sys.htf.escape_sc(l_init_animation))             ||
        apex_javascript.add_attribute('setCurrentTime' , l_set_current_time)                              ||
        apex_javascript.add_attribute('primaryColor'   , sys.htf.escape_sc(l_primary_color))              ||
        apex_javascript.add_attribute('textColor'      , sys.htf.escape_sc(l_text_color))                 ||
        apex_javascript.add_attribute('backgroundColor', sys.htf.escape_sc(l_background_color))           ||
        apex_javascript.add_attribute('borderColor'    , sys.htf.escape_sc(l_border_color), false, false) ||
      '});');

    p_result.is_navigable := true;
  end if;
exception
  when others then
    raise;
end render_timedropper;