defmodule Userteam1Web.ChallengeGroupAvatar do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  use Arc.Ecto.Definition

  @versions [:thumb]

  # To add a thumbnail version:
  # @versions [:original, :thumb]

  # Override the bucket on a per definition basis:
  # def bucket do
  #   :custom_bucket_name
  # end

  # Whitelist file extensions:
  # def validate({file, _}) do
  #   ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  # end

  # Define a thumbnail transformation:
  # def transform(:thumb, _) do
  #   {:convert, "-strip -thumbnail 250x250^ -gravity center -extent 250x250 -format png", :png}
  # end

  # Override the persisted filenames:
  # def filename(_version, {file, scope}) do
  #   IO.puts("scope")
  #   IO.inspect(scope)
  #   file_name = Path.basename(file.file_name, Path.extname(file.file_name))
  #   "#{scope.id}_#{file_name}"
  # end

  # Override the storage directory:
  def storage_dir(_, {_, scope}) do
    folder = "#{UUID.uuid5(nil, scope.name)}"
    "uploads/challengegroupavatar/#{folder}"
  end

  def remove(scope) do
    storage_dir(nil, {nil, scope}) |> File.rm_rf!()
  end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: MIME.from_path(file.file_name)]
  # end
end
