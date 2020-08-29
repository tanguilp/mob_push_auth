defmodule MobPushAuthWeb.RegisterEnrollLiveTest do
  use MobPushAuthWeb.ConnCase

  import Phoenix.LiveViewTest

  alias MobPushAuth.Toto

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:register_enroll) do
    {:ok, register_enroll} = Toto.create_register_enroll(@create_attrs)
    register_enroll
  end

  defp create_register_enroll(_) do
    register_enroll = fixture(:register_enroll)
    %{register_enroll: register_enroll}
  end

  describe "Index" do
    setup [:create_register_enroll]

    test "lists all register_enrolls", %{conn: conn, register_enroll: register_enroll} do
      {:ok, _index_live, html} = live(conn, Routes.register_enroll_index_path(conn, :index))

      assert html =~ "Listing Register enrolls"
    end

    test "saves new register_enroll", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.register_enroll_index_path(conn, :index))

      assert index_live |> element("a", "New Register enroll") |> render_click() =~
               "New Register enroll"

      assert_patch(index_live, Routes.register_enroll_index_path(conn, :new))

      assert index_live
             |> form("#register_enroll-form", register_enroll: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#register_enroll-form", register_enroll: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.register_enroll_index_path(conn, :index))

      assert html =~ "Register enroll created successfully"
    end

    test "updates register_enroll in listing", %{conn: conn, register_enroll: register_enroll} do
      {:ok, index_live, _html} = live(conn, Routes.register_enroll_index_path(conn, :index))

      assert index_live |> element("#register_enroll-#{register_enroll.id} a", "Edit") |> render_click() =~
               "Edit Register enroll"

      assert_patch(index_live, Routes.register_enroll_index_path(conn, :edit, register_enroll))

      assert index_live
             |> form("#register_enroll-form", register_enroll: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#register_enroll-form", register_enroll: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.register_enroll_index_path(conn, :index))

      assert html =~ "Register enroll updated successfully"
    end

    test "deletes register_enroll in listing", %{conn: conn, register_enroll: register_enroll} do
      {:ok, index_live, _html} = live(conn, Routes.register_enroll_index_path(conn, :index))

      assert index_live |> element("#register_enroll-#{register_enroll.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#register_enroll-#{register_enroll.id}")
    end
  end

  describe "Show" do
    setup [:create_register_enroll]

    test "displays register_enroll", %{conn: conn, register_enroll: register_enroll} do
      {:ok, _show_live, html} = live(conn, Routes.register_enroll_show_path(conn, :show, register_enroll))

      assert html =~ "Show Register enroll"
    end

    test "updates register_enroll within modal", %{conn: conn, register_enroll: register_enroll} do
      {:ok, show_live, _html} = live(conn, Routes.register_enroll_show_path(conn, :show, register_enroll))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Register enroll"

      assert_patch(show_live, Routes.register_enroll_show_path(conn, :edit, register_enroll))

      assert show_live
             |> form("#register_enroll-form", register_enroll: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#register_enroll-form", register_enroll: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.register_enroll_show_path(conn, :show, register_enroll))

      assert html =~ "Register enroll updated successfully"
    end
  end
end
